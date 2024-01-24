deviceTypesCommon = require '@resin.io/device-types/common'
{ networkOptions, commonImg, instructions } = deviceTypesCommon

module.exports =
	version: 1
	slug: 'bluechiptechnology-db1'
	aliases: [ 'bluechiptechnologydb1' ]
	name: 'Blue Chip Technology DB1'
	arch: 'aarch64'
	state: 'released'

	instructions: commonImg.instructions

	options: [ networkOptions.group ]

	yocto:
		machine: 'db1'
		image: 'balena-image-flasher'
		fstype: 'balenaos-img'
		version: 'yocto-kirkstone'
		deployArtifact: 'balena-image-flasher-db1.balenaos-img'
		compressed: true

	configuration:
		config:
			partition:
				primary: 1
			path: '/config.json'

	initialization: commonImg.initialization

