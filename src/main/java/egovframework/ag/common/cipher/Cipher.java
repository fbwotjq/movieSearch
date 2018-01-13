package egovframework.ag.common.cipher;

import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import egovframework.ag.common.cipher.Base64;
import egovframework.ag.common.cipher.BlockPadding;

/**
 * AIRA algorithm to encrypt or decrypt the data is the class that provides the ability to.
 * @author shson
 *
 */
public class Cipher {
	 
	private final static Logger logger = LogManager.getLogger();
	
	/**
	 * ARIA encryption algorithm block size
	 */
	private static final int ARIA_BLOCK_SIZE = 16;
	
	public static byte[] getCipherKey(){
		byte[] key = {42,52,64,1,0,127,123,75,34,12,43,74,36,28,92,16,41,53,63,2,7,121,124,76,37,13,46,73,37,23,96,14};
		return key;
	}
	
	/**
	 * ARIA algorithm to encrypt the data.
	 * @param data Target Data
	 * @param key Masterkey
	 * @param keySize Masterkey Size
	 * @param charset Data character set
	 * @return Encrypted data
	 * @throws UnsupportedEncodingException If character is not supported
	 * @throws InvalidKeyException If the Masterkey is not valid
	 */
	public static String encrypt(String data, byte[] key, int keySize, String charset)
			throws UnsupportedEncodingException, InvalidKeyException {
		if(data==null){
			return null;
		}
		if(data!=null){
			data = data.trim();
		}
		if(data.length()>0){
			byte[] encrypt = null;
			if( charset == null ) {
				encrypt = BlockPadding.getInstance().addPadding(data.getBytes(), ARIA_BLOCK_SIZE);
			} else {
				encrypt = BlockPadding.getInstance().addPadding(data.getBytes(charset), ARIA_BLOCK_SIZE);
			}
			ARIAEngine engine = new ARIAEngine(keySize);
			engine.setKey(key);
			engine.setupEncRoundKeys();
			
			int blockCount = 0;
			if(encrypt!=null){
				blockCount = encrypt.length / ARIA_BLOCK_SIZE;
			}else{
				return "";
			}
			
			for( int i = 0; i < blockCount; i++ ) {
				
				byte buffer[] = new byte[ARIA_BLOCK_SIZE];
				System.arraycopy(encrypt, (i * ARIA_BLOCK_SIZE), buffer, 0, ARIA_BLOCK_SIZE);
				
				buffer = engine.encrypt(buffer, 0);
				System.arraycopy(buffer, 0, encrypt, (i * ARIA_BLOCK_SIZE), buffer.length);
			}
			
			return Base64.toString(encrypt);
		}else{
			return "";
		}
	}
	
	/**
	 * ARIA algorithm to decrypt the data.
	 * @param data Target Data
	 * @param key Masterkey
	 * @param keySize Masterkey Size
	 * @param charset Data character set
	 * @return Decrypted data
	 * @throws UnsupportedEncodingException If character is not supported
	 * @throws InvalidKeyException If the Masterkey is not valid
	 */
	public static String decrypt(String data, byte[] key, int keySize, String charset)
			throws UnsupportedEncodingException, InvalidKeyException {
		if(data!=null){
			data = data.trim();
		}
		if(data.length()>0){
			byte[] decrypt = Base64.toByte(data);
			ARIAEngine engine = new ARIAEngine(keySize);
			engine.setKey(key);
			engine.setupDecRoundKeys();
			
			int blockCount = 0;
			if(decrypt!=null){
				blockCount = decrypt.length / ARIA_BLOCK_SIZE;
			}else{
				return "";
			}
			
			for( int i = 0; i < blockCount; i++ ) {
				
				byte buffer[] = new byte[ARIA_BLOCK_SIZE];
				System.arraycopy(decrypt, (i * ARIA_BLOCK_SIZE), buffer, 0, ARIA_BLOCK_SIZE);
				
				buffer = engine.decrypt(buffer, 0);
				System.arraycopy(buffer, 0, decrypt, (i * ARIA_BLOCK_SIZE), buffer.length);
			}
			
			if( charset == null ) {
				return new String(BlockPadding.getInstance().removePadding(decrypt, ARIA_BLOCK_SIZE)).trim();
			} else {
				return new String(BlockPadding.getInstance().removePadding(decrypt, ARIA_BLOCK_SIZE), charset).trim();
			}
		}else{
			return "";
		}
	}
	
	/**
	 * The sample code in the Cipher class
	 * @param args none
	 */
	public static void main(String args[]) {
		
		try {
			
			byte[] key = new byte[32];
			for( int i = 0; i < key.length; i++ ) {
				key[i] = (byte)i;
			}
			
			String data = "AS12대한민국";
			
			data = Cipher.encrypt(data, key, key.length*8, null);
			logger.debug(data);
			
			data = Cipher.decrypt(data, key, key.length*8, null);
			logger.debug(data);
			
		} catch(Exception e) {
			logger.debug(e.getMessage());
		}
	}
}
