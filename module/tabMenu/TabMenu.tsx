import { Box, Flex, Tab, TabIndicator, TabList, Tabs } from '@chakra-ui/react';
import React from 'react';
import { AppBar } from '../appBar/AppBar';
import { ProfileMobile } from '../profile/components/profileMobile/ProfileMobile';
import { SwitchTabPanels } from './switchTab/SwitchTabPanels';
import { useTabMenu } from './hooks/useTabMenu';

export const TabMenu = () => {
  const { tabSections, activeSectionIndex, changeActiveSection, handleChangeQueryParams } = useTabMenu();

  return (
    <Flex as={'section'} flex={4} flexDir="column">
      <Box display={{ base: 'block', lg: 'none' }}>
        <AppBar />
      </Box>
      <Tabs
        index={activeSectionIndex}
        onChange={changeActiveSection}
        size={'sm'}
        position={'relative'}
        variant="unstyled"
        paddingTop={{ lg: 10 }}
        ml={{ base: 1, sm: 5, md: 2 }}
        mr={{ base: 1, sm: 5, md: 2 }}
        w={{ base: '95vw', md: '100%' }}
      >
        <TabList>
          {tabSections.map((section) => {
            return (
              <Tab p={3} fontSize={'sm'} fontWeight="medium" key={section.name} onClick={handleChangeQueryParams}>
                {section.name}
              </Tab>
            );
          })}
        </TabList>
        <TabIndicator mt="-1px" height="2px" bg="blue.500" borderRadius="1px" />

        <Box display={{ base: 'block', md: 'none' }} pt={5}>
          <ProfileMobile />
        </Box>
        <SwitchTabPanels />
      </Tabs>
    </Flex>
  );
};
