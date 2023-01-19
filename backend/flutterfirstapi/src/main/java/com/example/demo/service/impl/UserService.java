package com.example.demo.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.model.UserModel;
import com.example.demo.repository.IUserRepository;
import com.example.demo.service.IUserService;

@Service
public class UserService implements IUserService {

    @Autowired
    IUserRepository userRepository;

    @Override
    public UserModel insertUser(UserModel user) {
        return userRepository.insertUser(user);
    }

    @Override
    public List<UserModel> getAllUser() {
        return userRepository.getAllUser();
    }

    @Override
    public UserModel updateUser(int id, UserModel user) {
        return userRepository.updateUser(id, user);
    }

    @Override
    public UserModel deleteUser(int id) {
        return userRepository.deleteUser(id);
    }

}
