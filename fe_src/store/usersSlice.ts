/* eslint-disable no-param-reassign */
import axios from 'axios';
import {
  filter,
  head,
  mapAccum,
  pipe,
  propEq,
// @ts-ignore
} from 'ramda';
import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';
import { BaseResponseT } from './commonTypes';
import {
  EmailValidationRequestT,
  EmailValidationResponseT,
  LoginRequestT,
  LoginResponseT,
  LoginStatusEnum,
  LogoutResponseT,
  ModifyEmailResponseT,
  UpdateProfileRequestT,
  UpdateProfileResponseT,
  UsersSliceT,
} from './usersSliceTypes';
// eslint-disable-next-line import/no-cycle
import { RootState } from './store';

const initialState: UsersSliceT = {
  loginStatus: undefined,
  expires: undefined,
  taxNumber: undefined,
  companyName: undefined,
  userRealName: undefined,
  userPermissions: undefined,
  userEmail: undefined,
  emailStatus: undefined,
  outcome: undefined,
  message: undefined,
};

export const checkLoginStatus = createAsyncThunk<LoginResponseT, void>(
  'users/checkLoginStatus',
  async () => {
    const response = await axios.get('/api/auth/checkToken.php');
    return response.data;
  },
);

export const login = createAsyncThunk<
LoginResponseT, LoginRequestT, { rejectValue: BaseResponseT }
>(
  'users/login',
  async (credentials, { rejectWithValue }) => {
    try {
      const response = await axios.post('/api/user/login.php', credentials);
      return response.data;
    } catch (e) {
      return rejectWithValue(e.response.data);
    }
  },
);

export const logout = createAsyncThunk<LogoutResponseT, void, { rejectValue: BaseResponseT }>(
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

export const updateProfile = createAsyncThunk<
UpdateProfileResponseT,
UpdateProfileRequestT,
{ rejectValue: BaseResponseT }
>(
  'users/updateProfile',
  async (requestData, { rejectWithValue }) => {
    try {
      const response = await axios.post('/api/user/update.php', requestData);
      // TODO: I do not really handle partial errors other than displaying them
      const errors = head(
        pipe(
          filter(propEq('outcome', 'failure')),
          mapAccum(
            (message: string, singleResponse: any) => [
              message
                ? `${message}. ${singleResponse.value}: ${singleResponse.message}`
                : `${singleResponse.value}: ${singleResponse.message}`,
              singleResponse.message,
            ],
            '',
          ),
        )(response.data),
      );
      if (errors) {
        return rejectWithValue({
          outcome: 'failure',
          message: errors,
        });
      }
      return response.data;
    } catch (e) {
      return rejectWithValue(e.response.data);
    }
  },
);

export const validateEmailAddress = createAsyncThunk<
EmailValidationResponseT, EmailValidationRequestT, { rejectValue: BaseResponseT }
>(
  'users/validateEmailAddress',
  async (requestData, { rejectWithValue }) => {
    try {
      const response = await axios.post('/api/user/emailvalidation.php', requestData);
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
  extraReducers: (builder) => {
    builder.addCase(checkLoginStatus.fulfilled, (state, { payload }) => {
      const {
        userPermissions,
        userEmail,
        emailStatus,
        loginStatus,
        taxNumber,
        userRealName,
        companyName,
        expires,
        outcome,
        message,
      } = payload;
      state.outcome = outcome;
      state.message = message;
      state.loginStatus = LoginStatusEnum[loginStatus];
      if (loginStatus !== LoginStatusEnum.NOT_LOGGED_IN) {
        state.userEmail = userEmail;
        state.emailStatus = emailStatus;
        state.taxNumber = taxNumber;
        state.userRealName = userRealName;
        state.userPermissions = Object.values(userPermissions).filter(
          (permission) => userPermissions.includes(permission),
        );
        state.companyName = companyName;
        state.expires = expires;
      }
    });

    builder.addCase(checkLoginStatus.rejected, (state, { payload }) => {
      const { outcome } = payload as LoginResponseT;
      state.outcome = outcome;
      state.message = 'API returned an error';
    });

    builder.addCase(updateProfile.fulfilled, (state, { payload }) => {
      const emailResponse = payload.find((response) => response.value === 'userEmail') as ModifyEmailResponseT;
      if (emailResponse?.ownEmail) {
        state.userEmail = emailResponse.userEmail;
        state.emailStatus = emailResponse.emailStatus;
      }
    });

    builder.addCase(updateProfile.rejected, (_, { payload }) => {
      throw new Error(payload.message || 'API returned an error');
    });

    builder.addCase(login.fulfilled, (state, { payload }) => {
      const {
        userPermissions,
        loginStatus,
        taxNumber,
        userRealName,
        userEmail,
        emailStatus,
        companyName,
        expires,
      } = payload;
      state.loginStatus = loginStatus;
      state.taxNumber = taxNumber;
      state.userRealName = userRealName;
      state.userEmail = userEmail;
      state.userPermissions = Object.values(userPermissions).filter(
        (permission) => userPermissions.includes(permission),
      );
      state.emailStatus = emailStatus;
      state.companyName = companyName;
      state.expires = expires;
    });

    builder.addCase(login.rejected, (_, { payload }) => {
      throw new Error(payload.message || 'API returned an error');
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
      state.message = payload.message;
    });

    builder.addCase(validateEmailAddress.fulfilled, (state, { payload }) => {
      state.emailStatus = payload.emailStatus;
    });

    builder.addCase(validateEmailAddress.rejected, (_, { payload }) => {
      throw new Error(payload.message || 'API returned an error');
    });
  },
});

export const companyName = (state: RootState) => state.users.companyName;
export const loginExpires = (state: RootState) => state.users.expires;
export const userEmail = (state: RootState) => state.users.userEmail;
export const userEmailStatus = (state: RootState) => state.users.emailStatus;
export const userLoginStatus = (state: RootState) => state.users.loginStatus;
export const userRealName = (state: RootState) => state.users.userRealName;
export const userTaxNumber = (state: RootState) => state.users.taxNumber;

export default usersSlice.reducer;
