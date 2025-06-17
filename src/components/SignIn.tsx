import React, { useState } from "react";

import { useSignInEmailPassword, useSignUpEmailPassword } from "@nhost/react";

export function SignIn() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [mode, setMode] = useState<"signIn" | "signUp">("signIn");

  const {
    signInEmailPassword,
    needsEmailVerification: signInNeedsEmailVerification,
    isLoading: isSignInLoading,
    isSuccess: isSignInSuccess,
    isError: isSignInError,
    error: signInError,
  } = useSignInEmailPassword();
  const {
    signUpEmailPassword,
    needsEmailVerification: signUpNeedsEmailVerification,
    isLoading: isSignUpLoading,
    isSuccess: isSignUpSuccess,
    isError: isSignUpError,
    error: signUpError,
  } = useSignUpEmailPassword();

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    if (mode === "signIn") {
      const { error } = await signInEmailPassword(email, password);
      if (error) {
        alert("Error signing in");
        console.log(error);
        return;
      }
      if (signInNeedsEmailVerification) {
        alert("Please verify your email before signing in.");
        return;
      }
      alert("Signed in successfully");
    } else {
      const { error } = await signUpEmailPassword(email, password);
      if (error) {
        alert("Error signing up");
        console.log(error);
        return;
      }
      if (signUpNeedsEmailVerification) {
        alert("Please verify your email before signing in.");
        return;
      }
      alert("Account created successfully");
    }
  };

  const isLoading = mode === "signIn" ? isSignInLoading : isSignUpLoading;
  const isError = mode === "signIn" ? isSignInError : isSignUpError;
  const error = mode === "signIn" ? signInError : signUpError;
  const isSuccess = mode === "signIn" ? isSignInSuccess : isSignUpSuccess;
  const needsEmailVerification =
    mode === "signIn"
      ? signInNeedsEmailVerification
      : signUpNeedsEmailVerification;

  return (
    <div className="my-4 max-w-xs mx-auto">
      <div className="flex mb-4">
        <button
          type="button"
          className={`flex-1 px-3 py-2 text-sm font-medium rounded-l-sm ${
            mode === "signIn"
              ? "bg-blue-500 text-white"
              : "bg-gray-200 text-gray-700"
          }`}
          onClick={() => setMode("signIn")}
        >
          Sign In
        </button>
        <button
          type="button"
          className={`flex-1 px-3 py-2 text-sm font-medium rounded-r-sm ${
            mode === "signUp"
              ? "bg-blue-500 text-white"
              : "bg-gray-200 text-gray-700"
          }`}
          onClick={() => setMode("signUp")}
        >
          Sign Up
        </button>
      </div>
      <form onSubmit={handleSubmit} className="space-y-4">
        <div>
          <label
            htmlFor="email"
            className="block text-sm font-medium text-gray-500"
          >
            Email
          </label>
          <div className="mt-1">
            <input
              name="email"
              type="email"
              placeholder="you@example.com"
              onChange={(e) => setEmail(e.target.value)}
              id="email"
              className="bg-gray-800 border-gray-600 text-gray-100 block w-full rounded-sm shadow-sm focus:shadow-md sm:text-sm"
            />
          </div>
        </div>
        <div>
          <label
            htmlFor="password"
            className="block text-sm font-medium text-gray-500"
          >
            Password
          </label>
          <div className="mt-1">
            <input
              name="password"
              type="password"
              placeholder="Your password"
              onChange={(e) => setPassword(e.target.value)}
              id="password"
              className="bg-gray-800 border-gray-600 text-gray-100 block w-full rounded-sm shadow-sm focus:shadow-md sm:text-sm"
            />
          </div>
        </div>
        <div>
          <button
            type="submit"
            className="rounded-sm border border-transparent px-3 py-2 text-sm font-medium leading-4 bg-slate-100 hover:bg-slate-200 text-gray-800 shadow-sm hover:focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 w-full "
            disabled={isLoading}
          >
            {mode === "signIn" ? "Sign In" : "Sign Up"}
          </button>
        </div>
        {isError && error && (
          <div className="text-red-500">{error.message}</div>
        )}
        {isSuccess && (
          <div className="text-green-500">
            {mode === "signIn"
              ? "Signed in successfully!"
              : "Account created successfully!"}
          </div>
        )}
        {needsEmailVerification && (
          <div className="text-yellow-500">
            Please verify your email before signing in.
          </div>
        )}
      </form>
    </div>
  );
}
