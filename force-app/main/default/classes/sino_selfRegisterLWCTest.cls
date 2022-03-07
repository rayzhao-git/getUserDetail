@IsTest
public with sharing class sino_selfRegisterLWCTest {
    @IsTest
    static void testSelfRegister() {
        String str = sino_selfRegisterLWC.selfRegister(
            'Test Team',
            'First',
            'Last',
            'emailaddr@test.com',
            'Testing team',
            '773-202-LUNA'
        );
    }
}