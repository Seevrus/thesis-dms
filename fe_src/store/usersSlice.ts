/* eslint-disable no-param-reassign */
import axios from 'axios';
import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';
import {
  CompleteRegistrationRequestT,
  CompleteRegistrationresponseT,
  LoginRequestT,
  LoginResponseT,
  LoginStatusEnum,
  LogoutResponseT,
  UsersSliceT,
  ValidateEmailAddressRequestT,
} from './usersSliceTypes';
// eslint-disable-next-line import/no-cycle
import { RootState } from './store';

const initialState: UsersSliceT = {
  loginStatus: null,
  expires: null,
  taxNumber: null,
  userPermissions: {},
  emailStatus: null,
  outcome: null,
  message: null,
};

export const checkLoginStatus = createAsyncThunk(
  'users/checkLoginStatus',
  async () => {
    const response = await axios.get('/api/auth/checkToken.php');
    return response.data as LoginResponseT;
  },
);

export const completeRegistration = createAsyncThunk(
  'users/registerEmailAddress',
  async (requestData: CompleteRegistrationRequestT, { rejectWithValue }) => {
    try {
      const response = await axios.post('/api/user/completeregistration.php', requestData);
      return response.data as CompleteRegistrationresponseT;
    } catch (e) {
      return rejectWithValue(e.response.data as CompleteRegistrationresponseT);
    }
  },
);

export const login = createAsyncThunk(
  'users/login',
  async (credentials: LoginRequestT, { rejectWithValue }) => {
    try {
      const response = await axios.post('/api/user/login.php', credentials);
      return response.data as LoginResponseT;
    } catch (e) {
      return rejectWithValue(e.response.data as LoginResponseT);
    }
  },
);

export const logout = createAsyncThunk(
  'users/logout',
  async (_, { rejectWithValue }) => {
    try {
      const response = await axios.post('/api/user/logout.php');
      return response.data as LogoutResponseT;
    } catch (e) {
      return rejectWithValue(e.response.data as LogoutResponseT);
    }
  },
);

export const validateEmailAddress = createAsyncThunk(
  'users/validateEmailAddress',
  async (requestData: ValidateEmailAddressRequestT, { rejectWithValue }) => {
    try {
      const response = await axios.post('/api/user/emailvalidation.php', requestData);
      return response.data as CompleteRegistrationresponseT;
    } catch (e) {
      return rejectWithValue(e.response.data);
    }
  },
);

const usersSlice = createSlice({
  name: 'users',
  initialState,
  reducers: {},
  extraReducers: (builder) => {
    builder.addCase(checkLoginStatus.fulfilled, (state, { payload }) => {
      const {
        userPermissions,
        emailStatus,
        loginStatus,
        taxNumber,
        expires,
        outcome,
        message,
      } = payload;
      state.outcome = outcome;
      state.message = message;
      state.loginStatus = LoginStatusEnum[loginStatus];
      if (loginStatus !== LoginStatusEnum.NOT_LOGGED_IN) {
        state.emailStatus = emailStatus;
        state.taxNumber = taxNumber;
        state.userPermissions = userPermissions;
        state.expires = expires;
      }
    });

    builder.addCase(checkLoginStatus.rejected, (state, { payload }) => {
      const { outcome } = payload as LoginResponseT;
      state.outcome = outcome;
      state.message = 'API returned an error';
    });

    builder.addCase(completeRegistration.fulfilled, (state, { payload }) => {
      const { emailStatus } = payload;
      state.emailStatus = emailStatus;
    });

    builder.addCase(completeRegistration.rejected, (_, { payload }) => {
      const { message } = payload as CompleteRegistrationresponseT;
      throw new Error(message || 'API returned an error');
    });

    builder.addCase(login.fulfilled, (state, { payload }) => {
      const {
        userPermissions,
        loginStatus,
        taxNumber,
        emailStatus,
        expires,
      } = payload;
      state.loginStatus = loginStatus;
      state.taxNumber = taxNumber;
      state.userPermissions = userPermissions;
      state.emailStatus = emailStatus;
      state.expires = expires;
    });

    builder.addCase(login.rejected, (_, { payload }) => {
      const { message } = payload as LoginResponseT;
      throw new Error(message || 'API returned an error');
    });

    builder.addCase(logout.fulfilled, (state, { payload }) => {
      const { loginStatus, message } = payload;
      state.loginStatus = loginStatus;
      state.expires = null;
      state.taxNumber = null;
      state.userPermissions = [];
      state.emailStatus = null;
      state.message = message;
    });

    builder.addCase(logout.rejected, (state, { payload }) => {
      const { message } = payload as LogoutResponseT;
      state.message = message;
    });

    builder.addCase(validateEmailAddress.fulfilled, (state, { payload }) => {
      state.emailStatus = payload.emailStatus;
    });

    builder.addCase(validateEmailAddress.rejected, (_, { payload }) => {
      const { message } = payload as CompleteRegistrationresponseT;
      throw new Error(message || 'API returned an error');
    });
  },
});

export const userEmailStatus = (state: RootState) => state.users.emailStatus;
export const userLoginStatus = (state: RootState) => state.users.loginStatus;
export const loginExpires = (state: RootState) => state.users.expires;

export default usersSlice.reducer;
