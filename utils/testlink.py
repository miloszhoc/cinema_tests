import testlink


class NoTestCaseInBuild(Exception):
    pass


class TestLinkReport:

    def __init__(self) -> None:
        '''
        Integration with TestLink.
        Mark test case as passed or failed in testlink.

        '''
        self.tls = testlink.TestLinkHelper().connect(testlink.TestlinkAPIClient)

    def __get_project_id(self):
        projects = self.tls.getProjects()
        return projects[0]['id']

    def __get_test_plan_id(self, test_plan_name):
        test_plan = self.tls.getProjectTestPlans(testprojectid=self.__get_project_id())
        return list(filter(lambda x: x['name'] == test_plan_name, test_plan))[0]['id']

    def __get_test_cases_from_test_plan(self, test_plan_name):
        d = dict()
        for k, v in self.tls.getTestCasesForTestPlan(testplanid=self.__get_test_plan_id(test_plan_name)).items():
            d[v[0]['tcase_id']] = {
                'tcase_id': v[0]['tcase_id'],
                'tcase_name': v[0]['tcase_name'],
                'full_external_id': v[0]['full_external_id']
            }
        return d

    def __get_build_id_for_test_plan(self, test_plan_name, build_name):
        build = list(filter(lambda x: x['name'] == build_name,
                            self.tls.getBuildsForTestPlan(testplanid=self.__get_test_plan_id(test_plan_name))))
        return (build[0]['id'], build[0]['name'])

    def report_test_case(self, test_case_external_id, status, test_plan_name, build_name):
        '''
        :param test_case_external_id: readable test case ID (eg C-1)
        :param status: p - passed, f - failed, b - blocked
        :param test_plan_name: name of the test plan
        :param build_name: name of the build
        :return:
        '''
        for k, v in self.tls.getTestCasesForTestPlan(testplanid=self.__get_test_plan_id(test_plan_name)).items():
            if v[0]['full_external_id'] == test_case_external_id:
                test_case_id = v[0]['tcase_id']
                break

        if not test_case_id:
            raise NoTestCaseInBuild('Test case not present in the selected build.')

        self.tls.reportTCResult(test_case_id, self.__get_test_plan_id(test_plan_name),
                                self.__get_build_id_for_test_plan(test_plan_name, build_name)[1],
                                status, '', user='admin', platformid=0)
