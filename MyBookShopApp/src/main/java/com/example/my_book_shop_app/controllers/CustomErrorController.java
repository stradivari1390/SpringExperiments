package com.example.my_book_shop_app.controllers;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CustomErrorController implements ErrorController {

    private static final String ERROR_PATH = "/error";

    @RequestMapping(ERROR_PATH)
    public String handleError(Model model, HttpServletRequest request) {
        Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
        Throwable throwable = (Throwable) request.getAttribute(RequestDispatcher.ERROR_EXCEPTION);
        if (status != null) {
            int statusCode = Integer.parseInt(status.toString());
            switch (statusCode) {
                case 400:
                    model.addAttribute("errorMessage", "Bad Request.");
                    break;
                case 401:
                    model.addAttribute("errorMessage", "Unauthorized.");
                    break;
                case 403:
                    model.addAttribute("errorMessage", "Forbidden.");
                    break;
                case 404:
                    model.addAttribute("errorMessage", "Page not found.");
                    break;
                case 500:
                    model.addAttribute("errorMessage", "Internal Server Error.");
                    break;
                default:
                    if (throwable != null) {
                        model.addAttribute("errorMessage", throwable.getMessage());
                    } else {
                        model.addAttribute("errorMessage", "An unknown error occurred.");
                    }
                    break;
            }
        } else {
            model.addAttribute("errorMessage", "An unknown error occurred.");
        }
        return "error";
    }
}