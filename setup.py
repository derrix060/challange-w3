"""
A simple REST API created on the w3 challenge.

:copyright: (c) Mario Apra
:license: Apache-2.0
"""
import setuptools

with open('README.md', 'r') as f:
    readme = f.read()

with open('requirements.txt', 'r') as f:
    install_requires = f.readlines()

test_requires = [
    'fakeredis==1.0.5',
]

setuptools.setup(
    name='challenge_w3',
    version='1.0.0',
    author='Mario Apra',
    author_email='mariotapra@gmail.com',
    url='https://github.com/derrix060/challange-w3',
    description='A simple REST API created on the w3 challenge.',
    license='Apache-2.0',
    long_description=readme,
    packages=setuptools.find_packages(exclude=["*.tests", "*.tests.*", "tests.*", "tests"]),
    include_package_data=True,
    package_dir={'challenge_w3': 'challenge_w3'},
    install_requires=install_requires,
    tests_require=test_requires,
    zip_safe=False,
    entry_points={
        'console_scripts': [
            'challenge_w3 = challenge_w3.api:main',
        ],
        'gui_scripts': []
    },
)
