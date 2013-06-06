package net.Cripto.Common;

import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Random;

public class SecureRandomNumber 
{
	public static Random getRandom() {
		try {
	        // Initialize a secure random number generator
	        SecureRandom secureRandom = SecureRandom.getInstance("SHA1PRNG");
	        
	        return secureRandom;
	        
	    } catch (NoSuchAlgorithmException noSuchAlgo)
		{
			System.out.println(" No Such Algorithm exists " + noSuchAlgo);
		}
		return null;
	}

}
