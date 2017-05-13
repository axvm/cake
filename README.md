# Cake

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
```

## Development

TODO: Write development instructions here

## Contributing

1. Fork it ( https://github.com/axvm/cake/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [[axvm]](https://github.com/axvm) Alexander Marchenko - creator, maintainer
