package com.example.my_book_shop_app.controllers;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CustomErrorController implements ErrorController {

    private static final String ERROR_MESSAGE = "errorMessage";

    @RequestMapping("/error")
    public String handleError(Model model, HttpServletRequest request) {
        Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
        Throwable throwable = (Throwable) request.getAttribute(RequestDispatcher.ERROR_EXCEPTION);
        if (status != null) {
            int statusCode = Integer.parseInt(status.toString());
            switch (statusCode) {
                case 400:
                    model.addAttribute(ERROR_MESSAGE, "Bad Request.");
                    break;
                case 401:
                    model.addAttribute(ERROR_MESSAGE, "Unauthorized.");
                    break;
                case 403:
                    model.addAttribute(ERROR_MESSAGE, "Forbidden.");
                    break;
                case 404:
                    model.addAttribute(ERROR_MESSAGE, "Page not found.");
                    break;
                case 405:
                    model.addAttribute(ERROR_MESSAGE, "Method not allowed.");
                    break;
                case 407:
                    model.addAttribute(ERROR_MESSAGE, "Authentication required.");
                    break;
                case 408:
                    model.addAttribute(ERROR_MESSAGE, "Request timeout.");
                    break;
                case 415:
                    model.addAttribute(ERROR_MESSAGE, "Unsupported media type.");
                    break;
                case 429:
                    model.addAttribute(ERROR_MESSAGE, "Too many requests.");
                    break;
                case 499:
                    model.addAttribute(ERROR_MESSAGE, "Client close request.");
                    break;
                case 500:
                    model.addAttribute(ERROR_MESSAGE, "Something went wrong.\nWe're working on it.");
                    break;
                default:
                    if (throwable != null) {
                        model.addAttribute(ERROR_MESSAGE, throwable.getMessage());
                    } else {
                        model.addAttribute(ERROR_MESSAGE, "An unknown error occurred.");
                    }
                    break;
            }
        } else {
            model.addAttribute(ERROR_MESSAGE, "An unknown error occurred.");
        }
        return "error";
    }
}