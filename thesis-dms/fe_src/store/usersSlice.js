/* eslint-disable no-param-reassign */
import axios from 'axios';
import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';

export const EMAIL_STATUS = {
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

export const completeRegistration = createAsyncThunk(
  'users/registerEmailAddress',
  async ({ email, password }, { getState }) => {
    try {
      const { users: { taxNumber } } = getState();
      const requestData = { taxNumber, email, password };
      const response = await axios.post('/api/user/completeregistration.php', requestData);
      return response.data;
    } catch (e) {
      return e.response.data;
    }
  },
);

export const login = createAsyncThunk(
  'users/login',
  async ({ taxNumber, loginPwd }, { rejectWithValue }) => {
    try {
      const credentials = { taxNumber, password: loginPwd };
      const response = await axios.post('/api/user/login.php', credentials);
      return response.data;
    } catch (e) {
      return rejectWithValue(e.response.data);
    }
  },
);

const usersSlice = createSlice({
  name: 'users',
  initialState,
  reducers: {},
  extraReducers: {
    [checkLoginStatus.fulfilled]: (state, action) => {
      const {
        emailStatus,
        loginStatus,
        taxNumber,
        expires,
      } = action.payload;
      state.loginStatus = LOGIN_STATUS[loginStatus];
      if (loginStatus !== LOGIN_STATUS.NOT_LOGGED_IN) {
        state.emailStatus = EMAIL_STATUS[emailStatus];
        state.taxNumber = taxNumber;
        state.expires = expires;
      }
    },
    [checkLoginStatus.rejected]: (state) => {
      state.error = 'API returned an error';
    },
    [login.fulfilled]: (state, action) => {
      const {
        loginStatus,
        taxNumber,
        emailStatus,
        expires,
      } = action.payload;
      state.loginStatus = LOGIN_STATUS[loginStatus];
      state.taxNumber = taxNumber;
      state.emailStatus = EMAIL_STATUS[emailStatus];
      state.expires = expires;
    },
    [login.rejected]: (state, action) => {
      const { message } = action.payload;
      state.error = message;
    },
    [completeRegistration.fulfilled]: (state, action) => {
      const { emailStatus, message, outcome } = action.payload;
      if (outcome === 'error' || outcome === 'failure') {
        state.error = message;
      } else {
        state.emailStatus = emailStatus;
      }
    },
    [completeRegistration.rejected]: (state) => {
      state.error = 'API returned an error';
    },
  },
});

export const userEmailStatus = (state) => state.users.emailStatus;
export const userLoginStatus = (state) => state.users.loginStatus;
export const loginExpires = (state) => state.users.expires;

export default usersSlice.reducer;
