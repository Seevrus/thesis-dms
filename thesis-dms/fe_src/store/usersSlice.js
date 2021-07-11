/* eslint-disable no-param-reassign */
import axios from 'axios';
import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';

const initialState = {
  taxNumber: null,
  loggedin: null,
  expires: null,
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
      const { status, taxNumber, expires } = action.payload;
      state.loggedin = status;
      if (status !== 0) {
        state.taxNumber = taxNumber;
        state.expires = expires;
      }
    },
    [login.fulfilled]: (state, action) => {
      const {
        outcome,
        message,
        status,
        taxNumber,
        expires,
      } = action.payload;
      if (outcome === 'error' || outcome === 'failure') {
        state.error = message;
      } else {
        state.loggedin = status;
        state.taxNumber = taxNumber;
        state.expires = expires;
      }
    },
  },
});

export const isUserLoggedin = (state) => state.users.loggedin;
export const selectErrorMessage = (state) => state.users.error;

export default usersSlice.reducer;
