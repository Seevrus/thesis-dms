/* eslint-disable no-param-reassign */
import axios from 'axios';
import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';

// eslint-disable-next-line import/no-cycle
import { RootState } from './store';
import { BaseResponseT } from './commonTypes';
import {
  FetchCompaniesResponseT,
  OtherUsersSliceT,
  SearchUserRequestT,
  SearchUserResponseT,
} from './otherUsersSliceTypes';

const initialState: OtherUsersSliceT = {
  companies: [],
  searchResults: [],
  selectedUser: undefined,
};

export const searchUsers = createAsyncThunk<
SearchUserResponseT, SearchUserRequestT, { rejectValue: BaseResponseT }
>(
  'otherUsers/searchUsers',
  async (keyword, { rejectWithValue }) => {
    try {
      const response = await axios.get(`/api/user/handle/search.php?keyword=${keyword}`);
      return response.data;
    } catch (e) {
      return rejectWithValue(e.response.data);
    }
  },
);

export const fetchCompanies = createAsyncThunk<
FetchCompaniesResponseT, null, { rejectValue: BaseResponseT }
>(
  'otherUsers/selectCompanies',
  async (_, { rejectWithValue }) => {
    try {
      const response = await axios.get('api/company/search.php');
      return response.data;
    } catch (e) {
      return rejectWithValue(e.response.data);
    }
  },
);

const otherUsersSlice = createSlice({
  name: 'otherUsers',
  initialState,
  reducers: {
    setUser: (state, action) => {
      const userTaxNumber: number = action.payload;
      state.selectedUser = state.searchResults.find(
        (user) => user.taxNumber === userTaxNumber,
      );
    },
  },
  extraReducers: (builder) => {
    builder.addCase(searchUsers.fulfilled, (state, { payload }) => {
      state.searchResults = payload.users;
    });
    builder.addCase(fetchCompanies.fulfilled, (state, { payload }) => {
      state.companies = payload.companies;
    });
  },
});

export const selectCompanies = (state: RootState) => state.otherUsers.companies;
export const selectSearchResults = (state: RootState) => state.otherUsers.searchResults;
export const selectSelectedUser = (state: RootState) => state.otherUsers.selectedUser;

export const { setUser } = otherUsersSlice.actions;

export default otherUsersSlice.reducer;
