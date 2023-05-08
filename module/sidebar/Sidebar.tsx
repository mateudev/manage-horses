import { Flex, Divider, Box, Text } from '@chakra-ui/react';
import { AppBar } from '../appBar/AppBar';
import { SideBarList } from './components/sideBarList/SideBarList';
import { ChakraNextLink } from '@/shared/chakraNextLink/ChakraNextLink';
import { PlusSquareIcon } from '@chakra-ui/icons';

interface SideBarProps {
  maxW?: number | string;
}

export const Sidebar = ({ maxW = 240 }: SideBarProps) => {
  return (
    <Flex
      position={'fixed'}
      bg="gray.900"
      borderRight="1px"
      borderRightColor="gray.200"
      h="100vh"
      backgroundColor={{ base: 'white', md: 'white' }}
      minW={240}
      flexDir={'column'}
      w={'100vw'}
      maxW={{ base: '100vw', md: maxW }}
    >
      <Box h={'90px'}>
        <AppBar />
      </Box>
      <Divider />

      <Box flex={1} overflowY={'auto'}>
        <SideBarList />
      </Box>
      <Divider />

      <Flex p={5} alignItems="center" justifyContent={'center'}>
        <ChakraNextLink
          href={'/add'}
          display={'flex'}
          alignItems={'center'}
          justifyContent={'center'}
          gap={1}
          border={'1px solid'}
          borderRadius={6}
          w={'100%'}
          height={'100%'}
          color={'white'}
          p={3}
          bg={'button.100'}
        >
          <PlusSquareIcon />
          <Text>Add horse</Text>
        </ChakraNextLink>
      </Flex>
    </Flex>
  );
};
