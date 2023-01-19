package com.example.demo.repository;

import java.util.List;

import com.example.demo.model.UserModel;

public interface IUserRepository {

    public UserModel insertUser(UserModel user);

    public List<UserModel> getAllUser();

    public UserModel updateUser(int id, UserModel user);

    public UserModel deleteUser(int id);

}
