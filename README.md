# Vagrant Lab

These are Vagrant clusters I'm using to quickly build out multi-system designs and test new software.

## Requirements
- [Vagrant](https://www.vagrantup.com/)
- [Virtualbox](https://www.virtualbox.org/)

## Notes
deploydata - Houses BASH scripts which will run on each VM.  This could be from applying a base configuration in 'init.sh' or downloading/compiling/installing new packages.

externalpackages.sh - Used to download packages to deploydata.  For the most part, each 'deploydata' script already has a built in to download a required package.  However, if there are multiple systems, this means that a download occurs on each VM prior to compiling/installing.  To cut down on this, files can be downloaded prior and saved to 'deploydata' and an additional line can be added to copy files from the host system to the guest systems.
```
#{system}.vm.provision "file", source: "deploydata/#{filename}", destination: "#{filedirectory}/#{filename}"
```
