# atpctrl

Command line tool that allows manipulation of SNS accounts compliant with AT protocol

 <p align="center">
<img src="https://img.shields.io/badge/macOS-12.0+-red.svg" />
<img src="https://img.shields.io/badge/Swift-5.10-DE5D43.svg" />
    <a href="https://bsky.app/profile/iroiro-work.bsky.social">
        <img src="https://img.shields.io/badge/Contact-@IroIro1234work-lightgrey.svg?style=flat" alt="Bluesky: 
@iroiro-work.bsky.social" />
    </a>
</p>

## Features
The following operations are supported in SNSs compliant with the AT protocol
- [x] Text Submission
- [x] Display profile
- [x] Search users
- [x] Display suggested users
- [x] Display suggested feeds
- [x] Display user lists
- [x] Display mutes accounts
- [ ] Display blocked accounts
  
These features are just examples and will be added as [ATProtoKit](https://github.com/MasterJ93/ATProtoKit) is developed.

## ToDo
In this project, we are planning to slowly implement the following
However, please note that this project is dependent on the development status of this API as it uses [ATProtoKit](https://github.com/MasterJ93/ATProtoKit), which is currently under development. Also, since we plan to use many experimental features, development will take time.
- [ ] Swift 6 Support
- [x] Swift Concurrency Support
- [x] Easy debugging capabilities with Swift Testing
- [x] Supports AT Protocol-enabled and command line-optimized features
- [ ] Secure storage of login information

## Problem
Currently, login information is stored in plain text in a text file. We plan to improve this situation eventually, but are having difficulty finding a suitable solution. We appreciate your understanding.

## Installation
Currently under development, installation is done using Makefile.
``` shell
cd path/to/repository
make install
```

## Uninstallation
Currently under development, uninstallation is done using Makefile.
``` shell
cd path/to/repository
make uninstall
```

## Resources
Currently under development and in preparation.

## License
This Swift package is MIT licensed. Please see LICENSE.md for more information.
