package com.example.demo.service;

import java.util.List;

import com.example.demo.model.UserModel;

public interface IUserService {

    public UserModel insertUser(UserModel user);

    public List<UserModel> getAllUser();

    public UserModel updateUser(int id, UserModel user);

    public UserModel deleteUser(int id);

}
