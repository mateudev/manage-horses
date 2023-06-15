import React from 'react';
import { useQueryClient, useMutation, useQuery } from '@tanstack/react-query';
import axios, { AxiosResponse } from 'axios';
import { Tab } from '@/utils/types';
import { useFetchTab } from './useFetchTab';

type Fn = (data: Tab & { name: string }) => Promise<AxiosResponse<any, any>>;

export const fetchTab = async (tabName: string, horseName: string) => {
  const result = await axios.get<Tab[]>(`/api/tab/${tabName}?name=${horseName}`);

  return result.data;
};

export const useAddRecordTab = (addServices: Fn, initial: Tab[], tabName: string, horseName: string) => {
  const queryClient = useQueryClient();
  const { data, isLoading, error, isSuccess, refetch } = useFetchTab(initial, tabName, horseName);

  const mutation = useMutation(addServices, {
    onSuccess: (data) => {
      queryClient.invalidateQueries([tabName]);
    },
    onError: (error) => {
      console.error('Wystąpił błąd podczas dodawania obiektu:', error);
    },
  });

  return { mutation, data, isLoading, error, isSuccess, refetch };
};
