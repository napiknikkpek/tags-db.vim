
fu! tags#db#init(dirname)
python3 << EOF

def set_tags():
    dirname = vim.eval('a:dirname')

    while dirname != "/":
        if os.path.exists(dirname + "/tags.db"):
            vim.command('setlocal tags={}'.format(dirname + "/tags"))
            return
        dirname = os.path.dirname(dirname)

set_tags()
EOF
endfu

python3 << EOF
import subprocess

def generate(db):
    tags = os.path.dirname(db) + '/tags'

    with open(db) as f:
        files = f.read().replace('\n', ' ').strip()

    if not files:
        files = "/dev/null"

    args = "ctags -f {} -R --sort=yes --kinds-C++=+p --fields=+iaS --extras=+q --languages=C,C++ {}".format(tags, files).split()

    subprocess.run(args)
EOF

fu! tags#db#reload()
  python3 generate(os.path.dirname(vim.eval('&l:tags')) + '/tags.db')
endfu

fu! tags#db#generate(db)
  python3 generate(vim.eval('a:db'))
endfu
