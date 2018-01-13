package egovframework.ag.common.aspect;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.aspectj.lang.JoinPoint;

public class TraceAspect {
	private static final Logger LOGGER = LogManager.getLogger();

	public void traceBefore(JoinPoint joinPoint) throws Throwable {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("[CALL TRACE] : " + joinPoint.getSignature().toShortString());
		}
	}
}
