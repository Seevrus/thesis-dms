/* eslint-disable import/no-cycle */
import { configureStore } from '@reduxjs/toolkit';

import activityFilterSlice from './activityFilterSlice';
import documentsSlice from './documentsSlice';
import userActivityScile from './userActivitySlice';
import usersSlice from './usersSlice';

const store = configureStore({
  reducer: {
    activityFilter: activityFilterSlice,
    documents: documentsSlice,
    userActivity: userActivityScile,
    users: usersSlice,
  },
});

export default store;

export type RootState = ReturnType<typeof store.getState>;
export type AppDispatch = typeof store.dispatch;
