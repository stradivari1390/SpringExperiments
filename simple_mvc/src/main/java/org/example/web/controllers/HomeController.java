package org.example.web.controllers;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {

    private final Logger logger = Logger.getLogger(HomeController.class);

    @GetMapping(value = "/home")
    public ModelAndView home(){
        logger.info("GET /home returns index.html");
        return new ModelAndView("index");
    }
}