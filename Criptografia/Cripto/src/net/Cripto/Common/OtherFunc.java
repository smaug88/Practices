package net.Cripto.Common;

import java.math.BigInteger;
import java.util.Random;

public class OtherFunc {

	public static BigInteger rndBigInt(BigInteger max) {
	    Random rnd = new Random();
	    do {
	        BigInteger i = new BigInteger(max.bitLength(), rnd);
	        if (i.compareTo(max) <= 0)
	            return i.abs();
	    } while (true);
	}
}
