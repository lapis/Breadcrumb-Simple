use inc::Module::Install;
name 'Breadcrumb-Simple';
all_from 'lib/Breadcrumb/Simple.pm';

requires 'FindBin'    => 0;
requires 'Text::MicroTemplate' => 0;

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
test_requires 'Test::Exception';

tests_recursive;
auto_include;
WriteAll;
