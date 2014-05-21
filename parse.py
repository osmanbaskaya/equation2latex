#! /usr/bin/python
# -*- coding: utf-8 -*-

__author__ = "Osman Baskaya"


import compiler
eq= "350**2+5*10"
ast= compiler.parse( eq )
ast = ast.getChildNodes()[0].getChildNodes()[0].getChildNodes()[0]
print ast

opSet = [compiler.ast.Add, compiler.ast.Power]


def f(node):
    if isinstance(node, compiler.ast.Add):
        return '(%s+%s)' % (f(node.left), f(node.right))
    elif isinstance(node, compiler.ast.Power):
        return '(%s^%s)' % (f(node.left), f(node.right))
    elif isinstance(node, compiler.ast.Mul):
        return '(%s*%s)' % (f(node.left), f(node.right))
    else:
        return node.value

print f(ast)
