# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# job titles from http://codepen.io/TimPietrusky/pen/CxiHF

# positions with openings
Position.create(name: 'Ultra Web RockStar', description: 'build websites', openings: 1)
Position.create(name: 'Firefox OS Wizard',  description: 'make sure the site works on Firefox', openings: 2)
Position.create(name: 'Kickstarter Zombie', description: 'monitor Kickstarter projects', openings: 3)
Position.create(name: 'SQL Designer', description: 'write queries', openings: 4)

# positions without openings
Position.create(name: 'Hashtag Agent', description: 'tweet about the company', openings: 0)
Position.create(name: 'Holy SEO Manager', description: 'improve SEO', openings: 0)
Position.create(name: 'Joomla Strategist', description: 'in case we start using Joomla', openings: 0)
Position.create(name: 'Github Mastermind', description: 'manage git repo', openings: 0)
