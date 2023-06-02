package com.example.my_book_shop_app.aspects;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class LoggingAspect {

    private final Logger log = LoggerFactory.getLogger(this.getClass());

    @Pointcut("within(com.example.my_book_shop_app.controllers..*)")
    public void controllersPackage() {
    }

    @Pointcut("within(com.example.my_book_shop_app.security.security_controller.AuthController)")
    public void authUserController() {
    }

    @Before("controllersPackage() || authUserController()")
    public void logMethodEntry(JoinPoint joinPoint) {
        log.info("Entering method: {} with arguments: {}", joinPoint.getSignature(), joinPoint.getArgs());
    }

    @AfterReturning(pointcut = "controllersPackage() || authUserController()", returning = "result")
    public void logMethodExit(JoinPoint joinPoint, Object result) {
        log.info("Exiting method: {} with result: {}", joinPoint.getSignature(), result);
    }

    @AfterThrowing(pointcut = "controllersPackage() || authUserController()", throwing = "exception")
    public void logException(JoinPoint joinPoint, Throwable exception) {
        log.error("Exception in method: {} with message: {}", joinPoint.getSignature(), exception.getMessage(), exception);
    }
}