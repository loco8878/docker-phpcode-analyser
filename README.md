# Docker image for PHP Compatibility Coding Standard and PHP analysis

## Based on php:8.0-alpine


### Build

    docker build -t phpcode-analyser .

### PHPCS

    docker run --rm -it --init -v "$PWD:$PWD" -w "$PWD" phpcode-analyser phpcs -p --standard=PSR12 --extensions=php --ignore=vendor .

### PHPCBF

    docker run --rm -it --init -v "$PWD:$PWD" -w "$PWD" phpcode-analyser phpcbf -p --standard=PSR12 --extensions=php --ignore=vendor .

### PHP Compatibility
    
    docker run --rm -it --init -v "$PWD:$PWD" -w "$PWD" phpcode-analyser phpcs -p --standard=PHPCompatibility --extensions=php --ignore=vendor --runtime-set testVersion 7.4 .

### PHPSTAN

    docker run --rm -it --init -v "$PWD:$PWD" -w "$PWD" phpcode-analyser phpstan analyse --level=7 <your/path/to/check>  
