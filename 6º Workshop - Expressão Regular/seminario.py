#!/usr/bin/python3
# -*- coding: utf-8 -*-

import re
from optparse import OptionParser

def blob():
    return open('pendrive_filesystem.dump', 'r').read()

def search(pattern):

    """ Seminario de seguranca
        Metodo para pesquisa do padrao regex
    """

    pattern = re.compile(r'{}'.format(pattern))
    print(pattern.findall(blob()))


if __name__ == '__main__':

    parser = OptionParser()
    usage = "usage: %prog [options] arg1"
    parser.add_option("-s", "--search", type="string",
        help="-s string, --search string",
        dest="pattern", default=".*")
    (options, args) = parser.parse_args()

    search(options.pattern)