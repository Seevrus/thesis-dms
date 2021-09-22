/* eslint-disable import/no-cycle */
import { configureStore } from '@reduxjs/toolkit';

import documentsSlice from './documentsSlice';
import userActivityScile from './userActivitySlice';
import usersSlice from './usersSlice';

const store = configureStore({
  reducer: {
    documents: documentsSlice,
    userActivity: userActivityScile,
    users: usersSlice,
  },
});

export default store;

export type RootState = ReturnType<typeof store.getState>;
export type AppDispatch = typeof store.dispatch;
