package net.Cripto.Common;

import java.io.UnsupportedEncodingException;

import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.SecretKey;
import javax.crypto.spec.DESKeySpec;
import javax.crypto.spec.SecretKeySpec;

import com.apache.commons.codec.binary.Base64;

public class DesEncrypter {
	Cipher ecipher;
	Cipher dcipher;

	DesEncrypter(SecretKey key) { 
		try {
			ecipher = Cipher.getInstance("DES");
			dcipher = Cipher.getInstance("DES");
			ecipher.init(Cipher.ENCRYPT_MODE, key);
			dcipher.init(Cipher.DECRYPT_MODE, key);

		} catch (javax.crypto.NoSuchPaddingException e) {
		} catch (java.security.NoSuchAlgorithmException e) {
		} catch (java.security.InvalidKeyException e) {
		}
	}

	public DesEncrypter(String clave) {
		try {
			SecretKey key = stringToSecretKey(clave);
			ecipher = Cipher.getInstance("DES");
			dcipher = Cipher.getInstance("DES");
			ecipher.init(Cipher.ENCRYPT_MODE, key);
			dcipher.init(Cipher.DECRYPT_MODE, key);

		} catch (javax.crypto.NoSuchPaddingException e) {
		} catch (java.security.NoSuchAlgorithmException e) {
		} catch (java.security.InvalidKeyException e) {
		}
	}

	@SuppressWarnings("hiding")
	public String encrypt(String str) {
		try {
			// Encode the string into bytes using utf-8
			byte[] utf8 = str.getBytes("UTF8");

			// Encrypt
			byte[] enc = ecipher.doFinal(utf8);

			// Encode bytes to base64 to get a string
			return new String(Base64.encodeBase64(enc));
		} catch (javax.crypto.BadPaddingException e) {
		} catch (IllegalBlockSizeException e) {
		} catch (UnsupportedEncodingException e) {
		} catch (java.io.IOException e) {
		}
		return null;
	}

	@SuppressWarnings("hiding")
	public String decrypt(String str) {
		try {
			// Decode base64 to get bytes
			byte[] dec = Base64.decodeBase64(str);

			// Decrypt
			byte[] utf8 = dcipher.doFinal(dec);

			// Decode using utf-8
			return new String(utf8, "UTF8");
		} catch (javax.crypto.BadPaddingException e) {
		} catch (IllegalBlockSizeException e) {
		} catch (UnsupportedEncodingException e) {
		} catch (java.io.IOException e) {
		}
		return null;
	}

	@SuppressWarnings("unused")
	public SecretKey stringToSecretKey(String clave) {
		SecretKey key = null;
		try {
			if (clave.length() > 7)
				throw new LongKeyException(
						"The key can't be longer than 7 characters");
			byte[] claveB = clave.getBytes();
			// A continuacion se dividira la clave en fragmentos de 7 bytes y se
			// le añadira el byte de paridad

			// En esta variable se almacenara el el fragmento sin paridad.
			// Se inicializa con un valor arbitrario para rellenar en caso de
			// que la clave sea pequeña
			byte[] claveBDESSinParidad = "ccccccc".getBytes();

			// En claveBDES se pondra la clave en bytes y con paridad.
			byte[] claveBDES = new byte[8];

			System.out.println(claveBDESSinParidad.length);
			Integer i = 0;
			// Se cogera fragmento a fragmento y se ira componiendo la clave DES
			while (i * 7 < claveB.length) {
				byte[] aux = "ccccccc".getBytes();
				i++;
				if (i * 7 <= claveB.length)
					System.arraycopy(claveB, (i * 7) - 7, aux, 0, 7);
				else
					// Caso final: lo que queda de la clave no llena un
					// fragmento, asi que se compensa con el valor inicial.
					System.arraycopy(claveB, (i * 7) - 7, aux, 0,
							7 - ((i * 7) - claveB.length));
				System.out.println("Fragmento: " + aux);

			}
			// Se añade la paridad
			// Para hacer claves mas largas se debe meter esto en un bucle y
			// repetir
			byte[] aux = new byte[7];
			System.arraycopy(claveBDESSinParidad, 0, aux, 0, 7);
			System.arraycopy(addParity(aux), 0, claveBDES, 0, 8);
			System.out.println(claveBDES);

			// Se comprueba que sea una clave DES valida
			try {
				boolean b = DESKeySpec.isParityAdjusted(claveBDES, 0);
			} catch (java.security.InvalidKeyException e) {
				System.out.println("Clave DES invalida");
			}

			// Se transforma en una SecretKey para que pueda ser usada por
			// Cipher
			key = new SecretKeySpec(claveBDES, "DES");

		} catch (Exception e) {
			System.out.println("Error");
			e.printStackTrace();
		}
		return key;

	}

	// Takes a 7-byte quantity and returns a valid 8-byte DES key.
	// The input and output bytes are big-endian, where the most significant
	// byte is in element 0.
	public static byte[] addParity(byte[] in) {
		byte[] result = new byte[8];

		// Keeps track of the bit position in the result
		int resultIx = 1;

		// Used to keep track of the number of 1 bits in each 7-bit chunk
		int bitCount = 0;

		// Process each of the 56 bits
		for (int i = 0; i < 56; i++) {
			// Get the bit at bit position i
			boolean bit = (in[6 - i / 8] & (1 << (i % 8))) > 0;

			// If set, set the corresponding bit in the result
			if (bit) {
				result[7 - resultIx / 8] |= (1 << (resultIx % 8)) & 0xFF;
				bitCount++;
			}

			// Set the parity bit after every 7 bits
			if ((i + 1) % 7 == 0) {
				if (bitCount % 2 == 0) {
					// Set low-order bit (parity bit) if bit count is even
					result[7 - resultIx / 8] |= 1;
				}
				resultIx++;
				bitCount = 0;
			}
			resultIx++;
		}
		return result;
	}

}
