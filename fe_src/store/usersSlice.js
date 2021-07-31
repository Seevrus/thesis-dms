/* eslint-disable no-param-reassign */
import axios from 'axios';
import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';

const USER_PERMISSIONS = {
  INACTIVE: 'INACTIVE',
  USER: 'USER',
  ACTIVITY_ADMINISTRATOR: 'ACTIVITY_ADMINISTRATOR',
  USER_ADMINISTRATOR: 'USER_ADMINISTRATOR',
  DOCUMENT_CREATOR: 'DOCUMENT_CREATOR',
};

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
  userPermissions: [],
  emailStatus: null,
  message: null,
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
  async ({ email, password }, { rejectWithValue }) => {
    try {
      const requestData = { email, password };
      const response = await axios.post('/api/user/completeregistration.php', requestData);
      return response.data;
    } catch (e) {
      return rejectWithValue(e.response.data);
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

export const logout = createAsyncThunk(
  'users/logout',
  async (_, { rejectWithValue }) => {
    try {
      const response = await axios.post('/api/user/logout.php');
      return response.data;
    } catch (e) {
      return rejectWithValue(e.response.data);
    }
  },
);

export const validateEmailAddress = createAsyncThunk(
  'users/validateEmailAddress',
  async ({ emailCode }, { rejectWithValue }) => {
    try {
      const response = await axios.post('/api/user/emailvalidation.php', { emailCode });
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
        userPermissions,
        emailStatus,
        loginStatus,
        taxNumber,
        expires,
      } = action.payload;
      state.loginStatus = LOGIN_STATUS[loginStatus];
      if (loginStatus !== LOGIN_STATUS.NOT_LOGGED_IN) {
        state.emailStatus = EMAIL_STATUS[emailStatus];
        state.taxNumber = taxNumber;
        state.userPermissions = Object.values(USER_PERMISSIONS).filter(
          (permission) => userPermissions.includes(permission),
        );
        state.expires = expires;
      }
    },
    [checkLoginStatus.rejected]: (state) => {
      state.message = 'API returned an error';
    },
    [completeRegistration.fulfilled]: (state, action) => {
      const { emailStatus } = action.payload;
      state.emailStatus = emailStatus;
    },
    [completeRegistration.rejected]: (state, action) => {
      state.message = action.payload.message;
    },
    [login.fulfilled]: (state, action) => {
      const {
        userPermissions,
        loginStatus,
        taxNumber,
        emailStatus,
        expires,
      } = action.payload;
      state.loginStatus = LOGIN_STATUS[loginStatus];
      state.taxNumber = taxNumber;
      state.userPermissions = Object.values(USER_PERMISSIONS).filter(
        (permission) => userPermissions.includes(permission),
      );
      state.emailStatus = EMAIL_STATUS[emailStatus];
      state.expires = expires;
    },
    [login.rejected]: (state, action) => {
      state.message = action.payload.message;
    },
    [logout.fulfilled]: (state, action) => {
      const { loginStatus, message } = action.payload;
      state.loginStatus = LOGIN_STATUS[loginStatus];
      state.expires = null;
      state.taxNumber = null;
      state.userPermissions = [];
      state.emailStatus = null;
      state.message = message;
    },
    [logout.rejected]: (state, action) => {
      state.message = action.payload.message;
    },
    [validateEmailAddress.fulfilled]: (state, action) => {
      const { emailStatus } = action.payload;
      state.emailStatus = emailStatus;
    },
    [validateEmailAddress.rejected]: (state, action) => {
      state.message = action.payload.message;
    },
  },
});

export const { reset } = usersSlice.actions;

export const userEmailStatus = (state) => state.users.emailStatus;
export const userLoginStatus = (state) => state.users.loginStatus;
export const loginExpires = (state) => state.users.expires;

export default usersSlice.reducer;
