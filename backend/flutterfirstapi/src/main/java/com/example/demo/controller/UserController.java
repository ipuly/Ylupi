package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.model.UserModel;
import com.example.demo.service.IUserService;

@RestController
@CrossOrigin(origins = "http://localhost:8080")
@RequestMapping("api/user")
public class UserController {

    @Autowired
    IUserService userService;

    @PostMapping("/insertUser")
    public UserModel insertUser(@RequestBody UserModel user) {
        return userService.insertUser(user);
    }

    @GetMapping("/getAllUser")
    public List<UserModel> getAllUser() {
        return userService.getAllUser();
    }

    @PutMapping("/updateUser/{id}")
    public UserModel updateUser(@PathVariable int id, @RequestBody UserModel user) {
        return userService.updateUser(id, user);
    }

    @DeleteMapping("/deleteUser/{id}")
    public UserModel deleteUser(@PathVariable int id) {
        return userService.deleteUser(id);
    }

}
