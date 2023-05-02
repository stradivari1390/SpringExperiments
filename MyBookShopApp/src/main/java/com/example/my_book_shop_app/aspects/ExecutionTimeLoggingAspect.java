package com.example.my_book_shop_app.aspects;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class ExecutionTimeLoggingAspect {

    private static final Logger log = LoggerFactory.getLogger(ExecutionTimeLoggingAspect.class);

    @Pointcut("within(com.example.my_book_shop_app.controllers.*)")
    public void controllersPackage() {
    }

    @Pointcut("within(com.example.my_book_shop_app.security.security_controller.AuthUserController)")
    public void authUserController() {
    }

    @Around("controllersPackage() || authUserController()")
    public Object logExecutionTime(ProceedingJoinPoint joinPoint) throws Throwable {
        long startTime = System.currentTimeMillis();
        Object result = joinPoint.proceed();
        long elapsedTime = System.currentTimeMillis() - startTime;

        log.info("Method {} executed in {} ms", joinPoint.getSignature(), elapsedTime);
        return result;
    }
}