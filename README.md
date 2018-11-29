# Cake [![Build Status](https://travis-ci.org/axvm/cake.svg?branch=master)](https://travis-ci.org/axvm/cake)

Cake is a powerful and flexible Make-like utility tool.
Implement tasks on plain crystal-lang and Make Tasks Great Again!

## Installation

Execute command to install `Cake`
```shell
$ curl https://raw.githubusercontent.com/axvm/cake/master/install.sh | bash
```

## Usage

Develop tasks in plain Crystal code in `Cakefile` and run them via `$ cake :task_name`

### bin/cake
```
  Usage:
    cake task_name
    cake -T

  Options:
    -T, --tasks                      Show all tasks
    -h, --help                       This info
    -v, --version                    Show version
```

### Cakefile sample
```Crystal
# Define task
task :task_name do
  # task logic
end

# Define task with description
desc "task useful description"
task :some_task do
  # 2 + 1
end

# Run one task from another
desc "invoke example"
task :first do
  # -Infinity / 0
  invoke! :second
end

task :second do
  # yay we are here!
end

# Execute shell commands
task :build do
  execute "shards build"

  # or with sweet logs
  execute(
    cmd: "shards build",
    announce: "Building binary...",
    success: "Binary built!",
    error: "Build failed."
  )
end

# Log things
task :deploy do
  # your deploy code
  log "Deploy successful!"
  log "Or errored.", 1
end
```

## Development

1. Implement feature and tests
2. Create pull request
3. ...
4. Profit!

## Contributing

1. Fork it ( https://github.com/axvm/cake/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [[axvm]](https://github.com/axvm) Alexander Marchenko - creator, maintainer
