package com.server.resource.controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ResourceController {

    @GetMapping("/testing")
    public String getMessages() {
        return "This is testing endpoint";
    }
}
