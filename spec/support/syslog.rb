# frozen_string_literal: true

shared_examples_for 'syslog resource' do
  it { is_expected.to have_syslog_resource_count(1) }

  it do
    is_expected.to contain_syslog('foo').only_with('name' => 'foo',
                                                   'ensure'      => 'present',
                                                   'facility'    => 'local2',
                                                   'level'       => '*',
                                                   'action_type' => 'file',
                                                   'action'      => '/var/log/foo.log',
                                                   'provider'    => 'augeas')
  end
end

shared_context 'syslog' do
  it { is_expected.to have_syslog_resource_count(0) }

  let :example_params do
    { 'foo' => { 'facility' => 'local2', 'level' => '*', 'action_type' => 'file', 'action' => '/var/log/foo.log' } }
  end

  context 'when syslog_hash is a Hash' do
    let(:params) { { syslog_hash: example_params } }
    let(:facts) { {} }

    include_examples 'syslog resource'
  end

  context 'when ::augeasproviders_syslog_hash is a Hash' do
    let(:params) { {} }
    let(:facts) { { augeasproviders_syslog_hash: example_params } }

    include_examples 'syslog resource'
  end
end
