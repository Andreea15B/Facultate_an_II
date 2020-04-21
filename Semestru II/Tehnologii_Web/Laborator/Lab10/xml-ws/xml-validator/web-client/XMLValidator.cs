﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:2.0.50727.42
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using System;
using System.ComponentModel;
using System.Diagnostics;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Xml.Serialization;

// 
// This source code was auto-generated by wsdl, Version=2.0.50727.42.
// 


/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.42")]
[System.Diagnostics.DebuggerStepThroughAttribute()]
[System.ComponentModel.DesignerCategoryAttribute("code")]
[System.Web.Services.WebServiceBindingAttribute(Name="XMLValidatorSoap", Namespace="http://www.infoiasi.ro/XMLValidator")]
public partial class XMLValidator : System.Web.Services.Protocols.SoapHttpClientProtocol {
    
    private System.Threading.SendOrPostCallback CheckIfExistsOperationCompleted;
    
    private System.Threading.SendOrPostCallback ValidateOperationCompleted;
    
    /// <remarks/>
    public XMLValidator() {
        this.Url = "http://localhost:8080/xml-validator/xml-validator.asmx";
    }
    
    /// <remarks/>
    public event CheckIfExistsCompletedEventHandler CheckIfExistsCompleted;
    
    /// <remarks/>
    public event ValidateCompletedEventHandler ValidateCompleted;
    
    /// <remarks/>
    [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://www.infoiasi.ro/XMLValidator/CheckIfExists", RequestNamespace="http://www.infoiasi.ro/XMLValidator", ResponseNamespace="http://www.infoiasi.ro/XMLValidator", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
    public bool CheckIfExists(string filename) {
        object[] results = this.Invoke("CheckIfExists", new object[] {
                    filename});
        return ((bool)(results[0]));
    }
    
    /// <remarks/>
    public System.IAsyncResult BeginCheckIfExists(string filename, System.AsyncCallback callback, object asyncState) {
        return this.BeginInvoke("CheckIfExists", new object[] {
                    filename}, callback, asyncState);
    }
    
    /// <remarks/>
    public bool EndCheckIfExists(System.IAsyncResult asyncResult) {
        object[] results = this.EndInvoke(asyncResult);
        return ((bool)(results[0]));
    }
    
    /// <remarks/>
    public void CheckIfExistsAsync(string filename) {
        this.CheckIfExistsAsync(filename, null);
    }
    
    /// <remarks/>
    public void CheckIfExistsAsync(string filename, object userState) {
        if ((this.CheckIfExistsOperationCompleted == null)) {
            this.CheckIfExistsOperationCompleted = new System.Threading.SendOrPostCallback(this.OnCheckIfExistsOperationCompleted);
        }
        this.InvokeAsync("CheckIfExists", new object[] {
                    filename}, this.CheckIfExistsOperationCompleted, userState);
    }
    
    private void OnCheckIfExistsOperationCompleted(object arg) {
        if ((this.CheckIfExistsCompleted != null)) {
            System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
            this.CheckIfExistsCompleted(this, new CheckIfExistsCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
        }
    }
    
    /// <remarks/>
    [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://www.infoiasi.ro/XMLValidator/Validate", RequestNamespace="http://www.infoiasi.ro/XMLValidator", ResponseNamespace="http://www.infoiasi.ro/XMLValidator", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
    public string Validate(string filename) {
        object[] results = this.Invoke("Validate", new object[] {
                    filename});
        return ((string)(results[0]));
    }
    
    /// <remarks/>
    public System.IAsyncResult BeginValidate(string filename, System.AsyncCallback callback, object asyncState) {
        return this.BeginInvoke("Validate", new object[] {
                    filename}, callback, asyncState);
    }
    
    /// <remarks/>
    public string EndValidate(System.IAsyncResult asyncResult) {
        object[] results = this.EndInvoke(asyncResult);
        return ((string)(results[0]));
    }
    
    /// <remarks/>
    public void ValidateAsync(string filename) {
        this.ValidateAsync(filename, null);
    }
    
    /// <remarks/>
    public void ValidateAsync(string filename, object userState) {
        if ((this.ValidateOperationCompleted == null)) {
            this.ValidateOperationCompleted = new System.Threading.SendOrPostCallback(this.OnValidateOperationCompleted);
        }
        this.InvokeAsync("Validate", new object[] {
                    filename}, this.ValidateOperationCompleted, userState);
    }
    
    private void OnValidateOperationCompleted(object arg) {
        if ((this.ValidateCompleted != null)) {
            System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
            this.ValidateCompleted(this, new ValidateCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
        }
    }
    
    /// <remarks/>
    public new void CancelAsync(object userState) {
        base.CancelAsync(userState);
    }
}

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.42")]
public delegate void CheckIfExistsCompletedEventHandler(object sender, CheckIfExistsCompletedEventArgs e);

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.42")]
[System.Diagnostics.DebuggerStepThroughAttribute()]
[System.ComponentModel.DesignerCategoryAttribute("code")]
public partial class CheckIfExistsCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
    
    private object[] results;
    
    internal CheckIfExistsCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
            base(exception, cancelled, userState) {
        this.results = results;
    }
    
    /// <remarks/>
    public bool Result {
        get {
            this.RaiseExceptionIfNecessary();
            return ((bool)(this.results[0]));
        }
    }
}

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.42")]
public delegate void ValidateCompletedEventHandler(object sender, ValidateCompletedEventArgs e);

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.42")]
[System.Diagnostics.DebuggerStepThroughAttribute()]
[System.ComponentModel.DesignerCategoryAttribute("code")]
public partial class ValidateCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
    
    private object[] results;
    
    internal ValidateCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
            base(exception, cancelled, userState) {
        this.results = results;
    }
    
    /// <remarks/>
    public string Result {
        get {
            this.RaiseExceptionIfNecessary();
            return ((string)(this.results[0]));
        }
    }
}