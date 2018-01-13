package egovframework.ag.common.aspect;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;

public class LoggingAspect {
	private static final Logger LOGGER = LogManager.getLogger();

	public Object logAround(ProceedingJoinPoint joinPoint) throws Throwable {
		if (LOGGER.isDebugEnabled()) {
		    //Object[] args = joinPoint.getArgs();
		    long currentTime = System.currentTimeMillis();

	    	Object returnObj = null;

	    	try {
	    		returnObj = joinPoint.proceed();
	    	}catch(Exception e) {
	    		LOGGER.debug(makeLogText(joinPoint, currentTime, e));
	    		throw e;
	    	}

	    	LOGGER.debug(makeLogText(joinPoint, currentTime, null));

	    	return returnObj;
		}else {
			return joinPoint.proceed();
		}

	}

	public void logBefore(JoinPoint joinPoint) throws Throwable {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("[CALL TRACE] : " + joinPoint.getSignature().toShortString());
		}
	}

	private String makeLogText(ProceedingJoinPoint joinPoint, long currentTime, Exception e) {
	    Object thisObj = joinPoint.getTarget();
	    String className = thisObj.getClass().getName();

		StringBuffer sb = new StringBuffer();
		sb.append("\n");
		sb.append("    [class] : " + className + "\n");
		sb.append("    [method] : " + joinPoint.getSignature().getName() + "()" + "\n");
		sb.append("    [소요시간]: {" + (System.currentTimeMillis()-currentTime) + "}ms" + "\n");
		if (e != null) {
			sb.append("    [Exception]: " + e.getMessage() + "\n");
		}

		return sb.toString();
	}
}
