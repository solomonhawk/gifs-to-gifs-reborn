# Introduction/Context/History

## What is this game?

It's basically Cards Against Humanity (or Apples to Apples) but with GIFs.
Those games are basically reaction games (or fill-in-the-blank). People use GIFs for reacting to things on the internet all the time. Therefore I thought it would be a fun pairing.

## Why? (prior art)

Inspired by a Pointless Corps project that David and Nate did back in 2016 (using Phoenix and Elixir), it turned out real cool!
https://github.com/vigetlabs/gif_bowl

I took an early stab at this using FireBase and React, but felt like I was hacking around a serverless architecture so much so that I ended up writing a node server that had god access to the data in FireBase in an attempt to handle some coordination/validation needs. This proved complicated - I had client code talking directly to FireBase in some cases and making API calls to the node server in other cases. It was a mess.

## Basic Rules

The game is organized into rounds.
- Each round a funmaster picks a prompt (gif, image, video)
- The other players select GIF reactions.
- The funmaster chooses their favorite reaction and the winner is awarded some points.
- A different player becomes the funmaster for the next round.
- Repeat until game is done.



# Code Organization

## Umbrella App

Pros:
- Cross project mix tasks/commands
- Useful tool for managing coupled OTP applications (version control/management, releases)

Cons:
- Extra layer to work with
- Additional configuration file at root of project
- Decomposing apps in an umbrella is basically equivalent to just having standalone apps in the first place

## Supervisors and GenServers

These components of OTP help us create robust systems that are fault-tolerant and resilient to errors.

Supervisors
  - manage child processes and restart them as necessary
  - group related components that may need to fail and restart together

GenServers
  - stateful processes that can be managed by Supervisors
  - keyword: stateful
  - alternate: `Agent`

# Wins and Losses

1. Win: Learning new stuff that I'm interested in

- Satisfying, helps prevent burnout
- Easiest when you have a real thing you want to make and you're forced to find solutions to all the various elements required to accomplish your goals

2. Win: Great language, great resources

- HexDocs are detailed, well-organized, and easy to follow.
- Tutorials cover a lot of territory and are a great starting point.
- Cognitive overhead of working in a functional programming paradigm is low
- Elixir is a joy to write (most of the time*)
- Formatter built-in to language

3. Win: Productivity/velocity

- It felt easy to approach new features with confidence
- Because writing the code was fun, I was able to crank through a lot of features quickly

4. Win: First-class documentation generation

- ExDoc
- doctests
- GitHub Pages deployment was super simple
- The documentation site looks amazing

5. Loss: Less mindshare means less community resources to fall back on (stackoverflow, blog posts, etc.)

6. Loss: Deployment isn't solved to the degree that e.g. Ruby/Rails is

7. Loss: Repetition of handlers across channels, GenServer client/server callbacks, game logic API














via_tuple
generating shortcodes
registry
GOTCHA: aliases in doctests are defined in the associated *_test.exs file that executes the doctests




Game Demo
Initial decisions for first pass mvp
Umbrella Apps - 👍mix tasks across apps, 👎shared config
Open Telecom Platform recap
GenServers
Countdown/timeouts
:ets
:observer.start() - demo killing game server process
ExDoc
Pros/Cons
writing similar functions in GameChannel, GameServer (client/server callbacks), and Game logic modules
Next Steps
determine scheme for selecting "prompts" (random? from which sources? curated? static? etc.)
implement selecting reactions