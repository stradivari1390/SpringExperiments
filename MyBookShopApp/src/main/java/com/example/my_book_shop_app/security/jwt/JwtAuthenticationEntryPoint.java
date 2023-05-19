package com.example.my_book_shop_app.security.jwt;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@Component
public class JwtAuthenticationEntryPoint implements AuthenticationEntryPoint {

    @Override
    public void commence(HttpServletRequest request, HttpServletResponse response,
                         AuthenticationException authException) throws IOException {
        String requestURI = request.getRequestURI();
        if (requestURI.equals("/my") || requestURI.equals("/archived") || requestURI.equals("/profile")) {
            response.sendRedirect("/signin");
        } else if (requestURI.equals("/rateBookReview") || requestURI.equals("/rateBook")) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Unauthorized");
        }
    }
}