# sample-go-cm

[![Circle CI](https://circleci.com/gh/jujugrrr/sample-go-cm.svg?style=svg)](https://circleci.com/gh/jujugrrr/sample-go-cm)

# Cookbook for sample-go

## Description

Configure a server to run the [sample-go](https://github.com/jujugrrr/sample-go) application

## Requirements

### Platform

* Ubuntu (14.10)

**Notes**: This cookbook has been tested on the listed platforms. It
may work on other platforms with or without modification.

## Usage

#### sample-go::default

Just include `sample-go-cm` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[sample-go-cm]"
  ]
}
```

## Attributes

#### golang::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['sample-go-cm']['artifact_url']</tt></td>
    <td>String</td>
    <td>Artifact URL</td>
    <td><tt>https://circle-artifacts.com/gh/jujugrrr/sample-go/17/artifacts/0/tmp/circle- artifacts.7XY5Omy/sample-go</tt></td>
  </tr>
</table>

## Testing

This project have [foodcritic](https://github.com/acrmp/foodcritic) for syntax checking and
[test-kitchen](https://github.com/opscode/test-kitchen) for integration testing. You can run the test suite by
typing: `rake kitchen:all` (may be slow for the first time).

In order to run these tests, the following
[requirements](https://github.com/opscode/kitchen-vagrant#-requirements) must be
satisfied:

* [Vagrant](http://vagrantup.com/) (>= 1.1.0)
* [VirtualBox](https://www.virtualbox.org/)
* [Vagrant Berkshelf Plugin](http://rubygems.org/gems/vagrant-berkshelf)

## Contributing

1. Fork the repository
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Test it by running `rake kitchen:all`
5. Submit a Pull Request
