/* eslint-disable no-param-reassign */
import axios from 'axios';
import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';
// eslint-disable-next-line import/no-cycle
import { RootState } from '../store';
import { BaseResponseT } from '../commonTypes';
import {
  DeliveryStatisticsResponseT,
  LoginStatisticsResponseT,
  SearchSimpleUserRequestT,
  SearchSimpleUserResponseT,
  StatisticsRequestT,
  StatisticsSliceT,
} from './statisticsSliceTypes';

const initialState: StatisticsSliceT = {
  lastLogin: {
    lastWeek: undefined,
    lastTwoWeeks: undefined,
    lastMonth: undefined,
    lastTwoMonths: undefined,
    lastThreeMonths: undefined,
    lastSixMonths: undefined,
    moreThanSixMonths: undefined,
  },
  payrollDelivery: {
    lastWeek: undefined,
    lastMonth: undefined,
    moreThanOneMonth: undefined,
    notDownloaded: undefined,
  },
  infoLetterDelivery: {
    lastWeek: undefined,
    lastMonth: undefined,
    moreThanOneMonth: undefined,
    notDownloaded: undefined,
  },
  simpleUsers: [],
  selectedUser: undefined,
};

export const fetchDeliveryStatistics = createAsyncThunk<
DeliveryStatisticsResponseT, StatisticsRequestT, { rejectValue: BaseResponseT }
>(
  'statistics/fetchDeliverytatistics',
  async (requestData, { rejectWithValue }) => {
    try {
      const response = await axios.post('api/statistics/delivery.php', requestData);
      return response.data;
    } catch (e) {
      return rejectWithValue(e.response.data);
    }
  },
);

export const fetchLoginStatistics = createAsyncThunk<
LoginStatisticsResponseT, StatisticsRequestT, { rejectValue: BaseResponseT }
>(
  'statistics/fetchLoginStatistics',
  async (requestData, { rejectWithValue }) => {
    try {
      const response = await axios.post('api/statistics/lastlogin.php', requestData);
      return response.data;
    } catch (e) {
      return rejectWithValue(e.response.data);
    }
  },
);

export const searchSimpleUsers = createAsyncThunk<
SearchSimpleUserResponseT, SearchSimpleUserRequestT, { rejectValue: BaseResponseT }
>(
  'statistics/fetchSimpleUser',
  async (requestData, { rejectWithValue }) => {
    try {
      const response = await axios.post('api/user/handle/search.php', requestData);
      return response.data;
    } catch (e) {
      return rejectWithValue(e.response.data);
    }
  },
);

const statisticsSlice = createSlice({
  name: 'statistics',
  initialState,
  reducers: {
    clearUser: (state) => { state.selectedUser = undefined; },
    setUser: (state, action) => {
      const userTaxNumber: number = action.payload;
      state.selectedUser = state.simpleUsers.find(
        (user) => user.taxNumber === userTaxNumber,
      );
    },
  },
  extraReducers: (builder) => {
    builder.addCase(fetchDeliveryStatistics.fulfilled, (state, { payload }) => {
      state.payrollDelivery = payload.payroll;
      state.infoLetterDelivery = payload.info;
    });

    builder.addCase(fetchLoginStatistics.fulfilled, (state, { payload }) => {
      state.lastLogin = payload.statistics;
    });

    builder.addCase(searchSimpleUsers.fulfilled, (state, { payload }) => {
      state.simpleUsers = payload.users;
    });
  },
});

export const selectInfoLetterDeliveryStatistics = (
  state: RootState,
) => state.statistics.infoLetterDelivery;
export const selectLoginStatistics = (state: RootState) => state.statistics.lastLogin;
export const selectPayrollDeliveryStatistics = (
  state: RootState,
) => state.statistics.payrollDelivery;
export const selectSimpleUsers = (state: RootState) => state.statistics.simpleUsers;
export const selectSelectedUser = (state: RootState) => state.statistics.selectedUser;

export const { clearUser, setUser } = statisticsSlice.actions;

export default statisticsSlice.reducer;
