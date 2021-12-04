/* eslint-disable no-param-reassign */
import axios from 'axios';
import {
  assoc,
  equals,
  find,
  map,
  pick,
  pipe,
  prop,
// @ts-ignore
} from 'ramda';
import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';

import {
  ActivityFilterResponseT,
  ActivityFilterSliceT,
  ActivityFilterT,
  RawFilterT,
  SavedFilterT,
  SaveFilterRequestT,
} from './activityFilterSliceTypes';
// eslint-disable-next-line import/no-cycle
import { RootState } from '../store';
import { BaseResponseT } from '../commonTypes';

const initialState: ActivityFilterSliceT = {
  activeFilter: {
    companyName: [],
    userRealName: [],
    categoryName: [],
    documentName: [],
    added: {},
    validUntil: {
      checked: true,
    },
    downloaded: {
      checked: false,
    },
  },
  savedFilters: [],
};

export const fetchColumnOptions = async (columnName: keyof ActivityFilterT) => {
  try {
    const response = await axios.post('/api/user/activity/options.php', { columnName });
    return response.data.options as string[];
  } catch (e) {
    throw new Error(e.data.message);
  }
};

export const fetchFilters = createAsyncThunk<ActivityFilterResponseT, void>(
  'activityFilter/fetchFilters',
  async (_, { rejectWithValue }) => {
    try {
      const response = await axios.get('/api/user/activity/filters/list.php');
      return response.data;
    } catch (e) {
      return rejectWithValue(e.response.data as BaseResponseT);
    }
  },
);

export const saveFilter = createAsyncThunk<BaseResponseT, SaveFilterRequestT>(
  'activityFilter/saveFilter',
  async (request, { rejectWithValue }) => {
    try {
      const response = await axios.post('/api/user/activity/filters/save.php', request);
      return response.data;
    } catch (e) {
      return rejectWithValue(e.response.data as BaseResponseT);
    }
  },
);

const activityFilterSlice = createSlice({
  name: 'activityFilter',
  initialState,
  reducers: {
    filterCleared: (state) => {
      state.activeFilter = initialState.activeFilter;
    },
    filterModified: (state, action: { payload: ActivityFilterT, type: string }) => {
      state.activeFilter = action.payload;
    },
  },
  extraReducers: (builder) => {
    builder.addCase(fetchFilters.fulfilled, (state, { payload }) => {
      const { filters } = payload;
      state.savedFilters = map((rawFilter: RawFilterT) => {
        const parsedActivityFilter = pipe(
          prop('activityFilter'),
          JSON.parse,
        )(rawFilter);
        return assoc('activityFilter', parsedActivityFilter, rawFilter);
      }, filters);
    });
  },
});

export const getMatchingSavedFilter:
(state: RootState) => SavedFilterT | undefined = (state) => find(
  pipe(
    prop('activityFilter'),
    equals(state.activityFilter.activeFilter),
  ),
  state.activityFilter.savedFilters,
);

export const getSavedFilters = (state: RootState) => state.activityFilter.savedFilters;

export const isAddedModified = (state: RootState) => !equals(
  pick(['added'], state.activityFilter.activeFilter),
  pick(['added'], initialState.activeFilter),
);
export const isCategoryNameModified = (state: RootState) => !equals(
  pick(['categoryName'], state.activityFilter.activeFilter),
  pick(['categoryName'], initialState.activeFilter),
);
export const isCompanyNameModified = (state: RootState) => !equals(
  pick(['companyName'], state.activityFilter.activeFilter),
  pick(['companyName'], initialState.activeFilter),
);
export const isDocumentNameModified = (state: RootState) => !equals(
  pick(['documentName'], state.activityFilter.activeFilter),
  pick(['documentName'], initialState.activeFilter),
);
export const isDownloadedModified = (state: RootState) => !equals(
  pick(['downloaded'], state.activityFilter.activeFilter),
  pick(['downloaded'], initialState.activeFilter),
);
export const isFilterModified = (state: RootState) => !equals(
  state.activityFilter.activeFilter,
  initialState.activeFilter,
);
export const isUserRealNameModified = (state: RootState) => !equals(
  pick(['userRealName'], state.activityFilter.activeFilter),
  pick(['userRealName'], initialState.activeFilter),
);
export const isValidUntilModified = (state: RootState) => !equals(
  pick(['validUntil'], state.activityFilter.activeFilter),
  pick(['validUntil'], initialState.activeFilter),
);
export const selectActiveFilter = (state: RootState) => state.activityFilter.activeFilter;

export const { filterCleared, filterModified } = activityFilterSlice.actions;

export default activityFilterSlice.reducer;
