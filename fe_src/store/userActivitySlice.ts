import { createAsyncThunk, createEntityAdapter, createSlice } from '@reduxjs/toolkit';
import axios from 'axios';

import { BaseResponseT } from './commonTypes';
// eslint-disable-next-line import/no-cycle
import { RootState } from './store';
import { ActivityRequestT, UserActivityT } from './userActivitySliceTypes';

const userActivityAdapter = createEntityAdapter<UserActivityT>();
const initialState = userActivityAdapter.getInitialState();

export const listUserActivity = createAsyncThunk<UserActivityT[], ActivityRequestT>(
  'userActivity/listUserActivity',
  async (requestData, { rejectWithValue }) => {
    try {
      const response = await axios.post('/api/user/activity/list.php', requestData);
      return response.data.activities;
    } catch (e) {
      return rejectWithValue(e.response.data as BaseResponseT);
    }
  },
);

const userActivitySlice = createSlice({
  name: 'userActivity',
  initialState,
  reducers: {},
  extraReducers: (builder) => {
    builder.addCase(listUserActivity.fulfilled, userActivityAdapter.setAll);
  },
});

export const {
  selectAll: selectActivities,
} = userActivityAdapter.getSelectors((state: RootState) => state.userActivity);

export default userActivitySlice.reducer;
