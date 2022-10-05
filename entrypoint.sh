#!/usr/bin/env bash

CMD ["nginx", "-g", "daemon off;"]

# Exit the script as soon as something fails.
set -e
exec "$@"

