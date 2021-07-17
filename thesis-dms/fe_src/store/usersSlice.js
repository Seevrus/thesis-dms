/* eslint-disable no-param-reassign */
import axios from 'axios';
import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';

const EMAIL_STATUS = {
  NO_EMAIL: 'NO_EMAIL',
  NOT_VALIDATED: 'NOT_VALIDATED',
  VALID_EMAIL: 'VALID_EMAIL',
};

export const LOGIN_STATUS = {
  NOT_LOGGED_IN: 'NOT_LOGGED_IN',
  LOGGED_IN: 'LOGGED_IN',
};

const initialState = {
  loginStatus: null,
  expires: null,
  taxNumber: null,
  emailStatus: null,
  error: null,
};

export const checkLoginStatus = createAsyncThunk(
  'users/checkLoginStatus',
  async () => {
    const response = await axios.get('/api/auth/checkToken.php');
    return response.data;
  },
);

export const login = createAsyncThunk(
  'users/login',
  async ({ taxNumber, loginPwd }) => {
    const credentials = { taxNumber, password: loginPwd };
    try {
      const response = await axios.post('/api/user/login.php', credentials);
      return response.data;
    } catch (e) {
      return e.response.data;
    }
  },
);

const usersSlice = createSlice({
  name: 'users',
  initialState,
  reducers: {},
  extraReducers: {
    [checkLoginStatus.fulfilled]: (state, action) => {
      const { loginStatus, taxNumber, expires } = action.payload;
      state.loginStatus = LOGIN_STATUS[loginStatus];
      if (loginStatus !== LOGIN_STATUS.NOT_LOGGED_IN) {
        state.taxNumber = taxNumber;
        state.expires = expires;
      }
    },
    [checkLoginStatus.rejected]: (state) => {
      state.error = 'API returned an error';
    },
    [login.fulfilled]: (state, action) => {
      const {
        outcome,
        message,
        loginStatus,
        taxNumber,
        emailStatus,
        expires,
      } = action.payload;
      if (outcome === 'error' || outcome === 'failure') {
        state.error = message;
      } else {
        state.loginStatus = LOGIN_STATUS[loginStatus];
        state.taxNumber = taxNumber;
        state.emailStatus = EMAIL_STATUS[emailStatus];
        state.expires = expires;
      }
    },
  },
});

export const userLoginStatus = (state) => state.users.loginStatus;
export const loginExpires = (state) => state.users.expires;

export default usersSlice.reducer;
