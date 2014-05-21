#! /usr/bin/python
# -*- coding: utf-8 -*-

__author__ = "Osman Baskaya & Onur Kuru"


import sys
import compiler


form = {'*': '\\times', '+': '+', '-': '-', '/': '/'}


def f(node):
    if isinstance(node, compiler.ast.Add):
        return '%s+%s' % (f(node.left), f(node.right))
    elif isinstance(node, compiler.ast.Power):
        return '(%s^{%s})' % (f(node.left), f(node.right))
    elif isinstance(node, compiler.ast.Mul):
        return '{%s}\\times{%s}' % (f(node.left), f(node.right))
    else:
        return node.value

eq = sys.argv[1]

def getLatex(eq):
    ast = compiler.parse(eq)
    ast = ast.getChildNodes()[0].getChildNodes()[0].getChildNodes()[0]
    return f(ast)


def preprocess_equation(eq):
    piIndex = eq.find('P')
    sumIndex = eq.find('S')
    if piIndex > -1:
        symbol = '\coprod'
        index = piIndex
    elif sumIndex > -1:
        symbol = '\sum'
        index = sumIndex
    else:
        return getLatex(eq)

    if index == 0:
        return "%s{%s}" % (symbol, getLatex(eq[1:]))
    else:
        eq1 = eq[:index-1]
        op = eq[index-1]
        eq2 = eq[index+1:]
        return "{%s}%s%s{%s}" % (getLatex(eq1), form[op], symbol, getLatex(eq2))

print preprocess_equation(eq)
