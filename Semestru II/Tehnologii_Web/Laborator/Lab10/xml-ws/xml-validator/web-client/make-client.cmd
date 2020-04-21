@echo off
rem Compileaza clientul de test care va valida un document XML aflat pe server
rem prin invocarea metodelor puse la dispozitie de servicul Web.

rem A se inlocui calea spre compilator cu cea existenta pe masina utilizata.
rem Pentru .NET 1.1, se substituie versiunea cu 'v1.1.4322'
c:\Windows\Microsoft.NET\Framework\v2.0.50727\csc /t:exe /r:System.Web.dll,System.XML.dll,System.Web.Services.dll XMLValidator.cs xml-validator-client.cs
