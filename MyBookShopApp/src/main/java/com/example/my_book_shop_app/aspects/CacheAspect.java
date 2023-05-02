package com.example.my_book_shop_app.aspects;

import com.example.my_book_shop_app.annotations.Cacheable;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;
import java.util.concurrent.ConcurrentHashMap;

@Aspect
@Component
public class CacheAspect {
    private final ConcurrentHashMap<String, Object> cache = new ConcurrentHashMap<>();

    @Around("@annotation(cacheable)")
    public Object caching(ProceedingJoinPoint joinPoint, Cacheable cacheable) throws Throwable {
        String cacheKey = generateCacheKey(joinPoint, cacheable);
        Object cachedValue = cache.get(cacheKey);

        if (cachedValue != null) {
            return cachedValue;
        }

        Object result = joinPoint.proceed();
        cache.put(cacheKey, result);
        return result;
    }

    private String generateCacheKey(ProceedingJoinPoint joinPoint, Cacheable cacheable) {
        StringBuilder keyBuilder = new StringBuilder(cacheable.value());
        keyBuilder.append(":");
        Object[] args = joinPoint.getArgs();
        for (Object arg : args) {
            keyBuilder.append(arg).append(",");
        }
        return keyBuilder.toString();
    }
}