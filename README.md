# Tengai

[![Build Status](https://travis-ci.org/zacstewart/tengai.png?branch=master)](https://travis-ci.org/zacstewart/tengai)
[![Dependency Status](https://gemnasium.com/zacstewart/tengai.png)](https://gemnasium.com/zacstewart/tengai)
[![Code Climate](https://codeclimate.com/github/zacstewart/tengai.png)](https://codeclimate.com/github/zacstewart/tengai)

_Tengai_ is a Gem for using the [NASA JPL HORIZONS System][1].

> The JPL HORIZONS on-line solar system data and ephemeris computation service
> provides access to key solar system data and flexible production of highly
> accurate ephemerides for solar system objects (603428 asteroids, 3184 comets,
> 176 planetary satellites, 8 planets, the Sun, L1, L2, select spacecraft, and
> system barycenters ). HORIZONS is provided by the Solar System Dynamics Group
> of the Jet Propulsion Laboratory.

## Usage
The API is currently very limited. The data from the telnet system is very
irregularly structured, and as such parsing it is a big deal.

```ruby
client = Tengai::Client.new # Connect a client to the telnet server
body = Tengai::Body.find(client, 499) # Get Mars
ephemeris = Tengai::Ephemeris.fetch(client, body,
  start_time: Date.today - 368, stop_time: Date.today) # Get ephemeris data for mars
```

## Contributing :octocat:

The project uses [Ragel State Machine Compiler][2] to generate the parser code.  If
you will be working on that, you'll need to install Ragel (`brew install
ragel`).

1. Fork
2. Create a feature branch
3. Add your feature and test it
4. Commit
5. Push your branch
6. Create a pull request

## Testing :ok_hand:
_Tengai_ is tested with Test::Unit. Tests are split unto units and integration.
Run them with `rake test:units` and `rake test:integration` respectively or
just `rake` to run them all.

[1]: http://ssd.jpl.nasa.gov/?horizons
[2]: http://www.complang.org/ragel/
