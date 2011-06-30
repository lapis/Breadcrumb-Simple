use inc::Module::Install;
name 'Breadcrumb-Simple';
all_from 'lib/Breadcrumb/Simple.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
